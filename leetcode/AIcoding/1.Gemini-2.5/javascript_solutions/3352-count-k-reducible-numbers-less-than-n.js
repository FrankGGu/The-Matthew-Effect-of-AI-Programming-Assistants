var countKReducibleNumbers = function(n, k) {
    let n_bigint;
    if (typeof n === 'string') {
        n_bigint = BigInt(n);
    } else {
        n_bigint = BigInt(n);
    }

    if (n_bigint <= 1n) {
        return 0;
    }

    const target_str = (n_bigint - 1n).toString();
    const len = target_str.length;

    const memo = Array(len).fill(0).map(() =>
        Array(k).fill(0).map(() =>
            Array(2).fill(0).map(() =>
                Array(2).fill(-1)
            )
        )
    );

    function solve(idx, current_sum_mod_k, tight, is_started) {
        if (idx === len) {
            return (current_sum_mod_k === 0 && is_started) ? 1 : 0;
        }

        if (memo[idx][current_sum_mod_k][tight][is_started] !== -1) {
            return memo[idx][current_sum_mod_k][tight][is_started];
        }

        let ans = 0;
        const upper_bound = tight ? parseInt(target_str[idx]) : 9;

        for (let digit = 0; digit <= upper_bound; digit++) {
            if (is_started || digit > 0) {
                ans += solve(
                    idx + 1,
                    (current_sum_mod_k + digit) % k,
                    tight && (digit === upper_bound),
                    true
                );
            } else {
                ans += solve(
                    idx + 1,
                    current_sum_mod_k,
                    tight && (digit === upper_bound),
                    false
                );
            }
        }

        return memo[idx][current_sum_mod_k][tight][is_started] = ans;
    }

    return solve(0, 0, true, false);
};