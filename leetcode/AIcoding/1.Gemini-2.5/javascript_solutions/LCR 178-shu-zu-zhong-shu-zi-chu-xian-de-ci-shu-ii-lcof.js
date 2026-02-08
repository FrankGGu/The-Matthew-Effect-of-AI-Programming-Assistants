var minTime = function(tasks) {
    const n = tasks.length;

    // Helper function to check if all tasks can be completed within a given time T
    const check = (T) => {
        let currentA_time = 0;
        let currentB_time = 0;
        const flexible_tasks = []; // Tasks that can be done by A (a_i <= T) AND B (b_i <= T)

        for (const [a, b] of tasks) {
            const can_do_on_A = (a <= T);
            const can_do_on_B = (b <= T);

            if (!can_do_on_A && !can_do_on_B) {
                return false; // This task cannot be done within time T on either machine
            } else if (can_do_on_A && !can_do_on_B) {
                currentA_time += a; // Must assign to A
            } else if (!can_do_on_A && can_do_on_B) {
                currentB_time += b; // Must assign to B
            } else { // can_do_on_A && can_do_on_B
                flexible_tasks.push({ a, b });
            }
        }

        // After mandatory assignments, check if limits are exceeded
        if (currentA_time > T || currentB_time > T) {
            return false;
        }

        // Distribute flexible tasks
        // Sort flexible tasks by `a_i - b_i` in ascending order.
        // This prioritizes tasks that are relatively faster on machine A.
        flexible_tasks.sort((t1, t2) => (t1.a - t1.b) - (t2.a - t2.b));

        for (const task of flexible_tasks) {
            // Try to assign to A if possible
            if (currentA_time + task.a <= T) {
                currentA_time += task.a;
            }
            // Else, try to assign to B if possible
            else if (currentB_time + task.b <= T) {
                currentB_time += task.b;
            }
            else {
                return false; // Cannot assign this task to either machine within T
            }
        }

        return true;
    };

    // Binary search for the minimum possible time T
    let left = 0;
    // A safe upper bound for the total time: sum of maximum of a_i or b_i for all tasks.
    // Max N = 2 * 10^5, Max a_i/b_i = 10^4. So max sum can be 2 * 10^5 * 10^4 = 2 * 10^9.
    let right = 2 * Math.pow(10, 9) + 7; // A sufficiently large upper bound
    let ans = right;

    while (left <= right) {
        const mid = left + Math.floor((right - left) / 2);
        if (check(mid)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
};