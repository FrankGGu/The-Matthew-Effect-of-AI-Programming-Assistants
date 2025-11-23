var isIdealPermutation = function(A) {
    const n = A.length;

    if (n <= 2) {
        return true;
    }

    let max_val_up_to_i_minus_2 = A[0];

    for (let i = 2; i < n; i++) {
        if (A[i] < max_val_up_to_i_minus_2) {
            return false;
        }
        max_val_up_to_i_minus_2 = Math.max(max_val_up_to_i_minus_2, A[i - 1]);
    }

    return true;
};