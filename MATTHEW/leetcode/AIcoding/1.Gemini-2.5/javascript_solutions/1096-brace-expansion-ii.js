var braceExpansionII = function(expression) {
    let i = 0; // Current index in the expression string

    // Helper to check if a character is a lowercase letter
    function isLetter(char) {
        return char >= 'a' && char <= 'z';
    }

    // Helper for set union
    function union(set1, set2) {
        return new Set([...set1, ...set2]);
    }

    // Helper for Cartesian product
    function product(set1, set2) {
        if (set1.size === 0 || set2.size === 0) {
            return new Set(); // Product with an empty set is an empty set
        }
        let resultSet = new Set();
        for (let s1 of set1) {
            for (let s2 of set2) {
                resultSet.add(s1 + s2);
            }
        }
        return resultSet;
    }

    // Parses an expression: term (',' term)*
    // Example: {a,b},c -> union({a,b}, c)
    function parseExpression() {
        let currentSet = parseTerm();
        while (i < expression.length && expression[i] === ',') {
            i++; // Consume ','
            currentSet = union(currentSet, parseTerm());
        }
        return currentSet;
    }

    // Parses a term: factor (factor)*
    // Example: {a,b}c -> product({a,b}, c)
    function parseTerm() {
        let currentSet = parseFactor();
        // A term can be followed by another factor without an explicit operator (implicit product)
        while (i < expression.length && (expression[i] === '(' || isLetter(expression[i]))) {
            currentSet = product(currentSet, parseFactor());
        }
        return currentSet;
    }

    // Parses a factor: letter | '(' expression ')'
    // Example: a, (a,b)
    function parseFactor() {
        if (expression[i] === '(') {
            i++; // Consume '('
            let subExpressionResult = parseExpression();
            i++; // Consume ')'
            return subExpressionResult;
        } else {
            // Must be a letter
            let letter = expression[i];
            i++; // Consume letter
            return new Set([letter]); // A single letter is a set containing that letter
        }
    }

    // Start parsing from the top-level expression
    let finalResult = parseExpression();

    // Convert the set to an array, sort it, and return
    return Array.from(finalResult).sort();
};