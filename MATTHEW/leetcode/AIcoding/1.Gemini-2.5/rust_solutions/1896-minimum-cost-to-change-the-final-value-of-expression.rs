impl Solution {
    pub fn min_cost_to_change_final_value(expression: String) -> i32 {
        let mut operand_stack: Vec<(i32, i32)> = Vec::new(); // (cost_to_0, cost_to_1)
        let mut operator_stack: Vec<char> = Vec::new();

        let precedence = |op: char| -> i32 {
            match op {
                '&' => 2,
                '|' => 1,
                _ => 0, // For '(' or other non-operators, effectively lowest precedence
            }
        };

        let mut apply_op = |op_stk: &mut Vec<char>, opd_stk: &mut Vec<(i32, i32)>| {
            let op = op_stk.pop().unwrap();
            let r_costs = opd_stk.pop().unwrap();
            let l_costs = opd_stk.pop().unwrap();

            let (l0, l1) = l_costs;
            let (r0, r1) = r_costs;

            let new_cost_to_0;
            let new_cost_to_1;

            if op == '&' {
                // To make L & R = 0:
                // Case 1: L=0, R=0. Cost: l0 + r0
                // Case 2: L=0, R=1. Cost: l0 + r1
                // Case 3: L=1, R=0. Cost: l1 + r0
                new_cost_to_0 = (l0 + r0).min(l0 + r1).min(l1 + r0);
                // To make L & R = 1:
                // Case 4: L=1, R=1. Cost: l1 + r1
                new_cost_to_1 = l1 + r1;
            } else { // op == '|'
                // To make L | R = 0:
                // Case 1: L=0, R=0. Cost: l0 + r0
                new_cost_to_0 = l0 + r0;
                // To make L | R = 1:
                // Case 2: L=0, R=1. Cost: l0 + r1
                // Case 3: L=1, R=0. Cost: l1 + r0
                // Case 4: L=1, R=1. Cost: l1 + r1
                new_cost_to_1 = (l0 + r1).min(l1 + r0).min(l1 + r1);
            }
            opd_stk.push((new_cost_to_0, new_cost_to_1));
        };

        for c in expression.chars() {
            match c {
                '0' => operand_stack.push((0, 1)),
                '1' => operand_stack.push((1, 0)),
                '(' => operator_stack.push(c),
                ')' => {
                    while let Some(&top_op) = operator_stack.last() {
                        if top_op == '(' {
                            break;
                        }
                        apply_op(&mut operator_stack, &mut operand_stack);
                    }
                    operator_stack.pop(); // Pop the '('
                },
                '&' | '|' => {
                    while let Some(&top_op) = operator_stack.last() {
                        if precedence(top_op) < precedence(c) {
                            break;
                        }
                        apply_op(&mut operator_stack, &mut operand_stack);
                    }
                    operator_stack.push(c);
                },
                _ => {}, // Should not happen for valid expressions
            }
        }

        while !operator_stack.is_empty() {
            apply_op(&mut operator_stack, &mut operand_stack);
        }

        let (final_cost_to_0, final_cost_to_1) = operand_stack.pop().unwrap();
        final_cost_to_0.min(final_cost_to_1)
    }
}