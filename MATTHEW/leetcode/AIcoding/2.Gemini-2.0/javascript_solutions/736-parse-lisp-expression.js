var evaluate = function(expression) {
    function parse(s) {
        let i = 0;
        let vars = {};

        function evalExpr() {
            if (s[i] === '(') {
                i++;
                let op = "";
                while (s[i] !== ' ' && s[i] !== ')') {
                    op += s[i];
                    i++;
                }
                i++;

                if (op === "let") {
                    let newVars = {};
                    while (s[i] !== ')') {
                        let varName = "";
                        while (s[i] !== ' ' && s[i] !== ')') {
                            varName += s[i];
                            i++;
                        }
                        i++;

                        if (s[i] === '(' || (s[i] >= '0' && s[i] <= '9') || s[i] === '-' || (s[i] >= 'a' && s[i] <= 'z')) {
                            let val = evalExpr();
                            newVars[varName] = val;
                        } else {
                            newVars[varName] = varName;
                            i++;
                        }

                        if (s[i] === ')') {
                            break;
                        }
                    }
                    let tempVars = Object.assign({}, vars);
                    for (let key in newVars) {
                        vars[key] = newVars[key];
                    }
                    i++;
                    let res = evalExpr();
                    vars = tempVars;
                    return res;
                } else if (op === "add") {
                    let val1 = evalExpr();
                    let val2 = evalExpr();
                    i++;
                    return val1 + val2;
                } else if (op === "mult") {
                    let val1 = evalExpr();
                    let val2 = evalExpr();
                    i++;
                    return val1 * val2;
                }
            } else {
                let numStr = "";
                while (i < s.length && s[i] !== ' ' && s[i] !== ')') {
                    numStr += s[i];
                    i++;
                }

                if (numStr[0] >= '0' && numStr[0] <= '9' || numStr[0] === '-') {
                    return parseInt(numStr);
                } else {
                    if (vars[numStr] !== undefined && typeof vars[numStr] === 'number') {
                      return vars[numStr];
                    } else if (vars[numStr] !== undefined) {
                      return parse(vars[numStr]);
                    }
                    return vars[numStr];
                }

            }
        }

        return evalExpr();
    }

    return parse(expression);
};