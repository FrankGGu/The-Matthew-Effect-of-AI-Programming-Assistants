function basicCalculatorIV(expression, evalvars, evalints) {
    let tokens;
    let tokenIndex;
    let varMap = new Map();

    for (let i = 0; i < evalvars.length; i++) {
        varMap.set(evalvars[i], evalints[i]);
    }

    // Tokenize the expression
    function tokenize(exp) {
        // Regex to match numbers, single lowercase letters (variables), or operators/parentheses
        return exp.match(/\d+|[a-z]|[+\-*/()]/g);
    }

    // Represents a polynomial as a Map<string, number>
    // Key: sorted and joined variable string (e.g., "a*b", "x", or "" for constant)
    // Value: coefficient

    // Helper function to add two polynomials
    function add(poly1, poly2) {
        const result = new Map(poly1);
        for (const [key, val] of poly2.entries()) {
            result.set(key, (result.get(key) || 0) + val);
        }
        return result;
    }

    // Helper function to subtract two polynomials
    function subtract(poly1, poly2) {
        const result = new Map(poly1);
        for (const [key, val] of poly2.entries()) {
            result.set(key, (result.get(key) || 0) - val);
        }
        return result;
    }

    // Helper function to multiply two polynomials
    function multiply(poly1, poly2) {
        const result = new Map();
        for (const [key1, val1] of poly1.entries()) {
            for (const [key2, val2] of poly2.entries()) {
                const newVal = val1 * val2;

                let vars1 = key1 === "" ? [] : key1.split('*');
                let vars2 = key2 === "" ? [] : key2.split('*');

                const combinedVars = [...vars1, ...vars2].sort();
                const newKey = combinedVars.join('*');

                result.set(newKey, (result.get(newKey) || 0) + newVal);
            }
        }
        return result;
    }

    // Recursive descent parser functions
    // factor -> number | variable | (expression)
    function parseFactor() {
        const token = tokens[tokenIndex];
        let poly = new Map();

        if (token === '(') {
            tokenIndex++; // Consume '('
            poly = parseExpression();
            tokenIndex++; // Consume ')'
        } else if (/\d+/.test(token)) { // Number
            poly.set("", parseInt(token));
            tokenIndex++;
        } else if (/[a-z]/.test(token)) { // Variable
            if (varMap.has(token)) { // Substitution available
                poly.set("", varMap.get(token));
            } else { // No substitution, keep as variable
                poly.set(token, 1);
            }
            tokenIndex++;
        }
        return poly;
    }

    // term -> factor (* factor)*
    function parseTerm() {
        let poly = parseFactor();
        while (tokenIndex < tokens.length && tokens[tokenIndex] === '*') {
            tokenIndex++; // Consume '*'
            poly = multiply(poly, parseFactor());
        }
        return poly;
    }

    // expression -> term (+ term | - term)*
    function parseExpression() {
        let poly = parseTerm();
        while (tokenIndex < tokens.length && (tokens[tokenIndex] === '+' || tokens[tokenIndex] === '-')) {
            const op = tokens[tokenIndex];
            tokenIndex++; // Consume op
            if (op === '+') {
                poly = add(poly, parseTerm());
            } else {
                poly = subtract(poly, parseTerm());
            }
        }
        return poly;
    }

    tokens = tokenize(expression);
    tokenIndex = 0;

    const finalPoly = parseExpression();

    // Format output
    const result = [];
    const terms = Array.from(finalPoly.entries());

    // Filter out zero coefficients
    const nonZeroTerms = terms.filter(([, val]) => val !== 0);

    // Sort terms:
    // 1. By degree (number of variables in the term) in descending order.
    // 2. If degrees are equal, by alphabetical order of variables in ascending order.
    nonZeroTerms.sort((a, b) => {
        const [keyA] = a;
        const [keyB] = b;

        const varsA = keyA === "" ? [] : keyA.split('*');
        const varsB = keyB === "" ? [] : keyB.split('*');

        // Sort by degree (descending)
        if (varsA.length !== varsB.length) {
            return varsB.length - varsA.length;
        }

        // Sort by alphabetical order of variables (ascending)
        return keyA.localeCompare(keyB);
    });

    // Convert to string format
    for (const [key, val] of nonZeroTerms) {
        if (key === "") { // Constant term
            result.push(val.toString());
        } else { // Variable term
            result.push(`${val}*${key}`);
        }
    }

    return result;
}