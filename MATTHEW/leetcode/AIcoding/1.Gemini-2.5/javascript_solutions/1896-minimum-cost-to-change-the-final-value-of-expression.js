var minCostToChangeFinalValue = function(expression) {
    const values = []; // Stores [cost_to_make_0, cost_to_make_1]
    const ops = [];     // Stores operators and parentheses

    const evaluate = (op, L, R) => {
        const c0L = L[0], c1L = L[1]; // Costs for left operand
        const c0R = R[0], c1R = R[1]; // Costs for right operand

        let new_c0, new_c1;

        if (op === '&') {
            // Calculate cost to make the expression '0'
            // Option 1: Keep '&' operator. To get 0, at least one operand must be 0.
            //   L=0, R=0: c0L + c0R
            //   L=0, R=1: c0L + c1R
            //   L=1, R=0: c1L + c0R
            const cost_to_make_0_with_and = Math.min(c0L + c0R, c0L + c1R, c1L + c0R);
            // Option 2: Change '&' to '|' (cost +1). To get 0, both operands must be 0.
            //   L=0, R=0: c0L + c0R + 1
            const cost_to_make_0_with_or_changed = c0L + c0R + 1;
            new_c0 = Math.min(cost_to_make_0_with_and, cost_to_make_0_with_or_changed);

            // Calculate cost to make the expression '1'
            // Option 1: Keep '&' operator. To get 1, both operands must be 1.
            //   L=1, R=1: c1L + c1R
            const cost_to_make_1_with_and = c1L + c1R;
            // Option 2: Change '&' to '|' (cost +1). To get 1, at least one operand must be 1.
            //   L=0, R=1: c0L + c1R + 1
            //   L=1, R=0: c1L + c0R + 1
            //   L=1, R=1: c1L + c1R + 1
            const cost_to_make_1_with_or_changed = Math.min(c0L + c1R, c1L + c0R, c1L + c1R) + 1;
            new_c1 = Math.min(cost_to_make_1_with_and, cost_to_make_1_with_or_changed);

        } else if (op === '|') {
            // Calculate cost to make the expression '0'
            // Option 1: Keep '|' operator. To get 0, both operands must be 0.
            //   L=0, R=0: c0L + c0R
            const cost_to_make_0_with_or = c0L + c0R;
            // Option 2: Change '|' to '&' (cost +1). To get 0, at least one operand must be 0.
            //   L=0, R=0: c0L + c0R + 1
            //   L=0, R=1: c0L + c1R + 1
            //   L=1, R=0: c1L + c0R + 1
            const cost_to_make_0_with_and_changed = Math.min(c0L + c0R, c0L + c1R, c1L + c0R) + 1;
            new_c0 = Math.min(cost_to_make_0_with_or, cost_to_make_0_with_and_changed);

            // Calculate cost to make the expression '1'
            // Option 1: Keep '|' operator. To get 1, at least one operand must be 1.
            //   L=0, R=1: c0L + c1R
            //   L=1, R=0: c1L + c0R
            //   L=1, R=1: c1L + c1R
            const cost_to_make_1_with_or = Math.min(c0L + c1R, c1L + c0R, c1L + c1R);
            // Option 2: Change '|' to '&' (cost +1). To get 1, both operands must be 1.
            //   L=1, R=1: c1L + c1R + 1
            const cost_to_make_1_with_and_changed = c1L + c1R + 1;
            new_c1 = Math.min(cost_to_make_1_with_or, cost_to_make_1_with_and_changed);
        }
        return [new_c0, new_c1];
    };

    for (let i = 0; i < expression.length; i++) {
        const char = expression[i];
        if (char === '(') {
            ops.push(char);
        } else if (char === '0') {
            values.push([0, 1]); // Cost to make 0 is 0, Cost to make 1 is 1
        } else if (char === '1') {
            values.push([1, 0]); // Cost to make 0 is 1, Cost to make 1 is 0
        } else if (char === '&' || char === '|') {
            ops.push(char);
        } else if (char === ')') {
            // Problem states "The expression is fully parenthesized and contains only '0', '1', '&', '|', '(', and ')'."
            // Also, "A valid expression is either a digit ('0' or '1') or an expression of the form (expr1 op expr2)"
            // This means when ')' is encountered, it must be closing an (expr1 op expr2) structure.
            // So, there will always be an operator on top of the ops stack, followed by a '('.

            const R = values.pop();
            const L = values.pop();
            const actualOp = ops.pop(); // This must be '&' or '|'
            ops.pop(); // Pop the matching '('

            const result = evaluate(actualOp, L, R);
            values.push(result);
        }
    }

    const finalResult = values.pop();
    return Math.min(finalResult[0], finalResult[1]);
};