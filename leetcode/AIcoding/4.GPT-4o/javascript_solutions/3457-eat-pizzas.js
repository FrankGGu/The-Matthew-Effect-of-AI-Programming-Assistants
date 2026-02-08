function maxSlices(A, L, R) {
    let left = L;
    let right = R;
    let slices = 0;

    for (let i = 0; i < A.length; i++) {
        if (left > 0 && A[i] < R) {
            slices++;
            left--;
        } else if (right > 0 && A[i] >= R) {
            slices++;
            right--;
        }
    }

    return slices;
}

function maxPizza(A, L, R) {
    return maxSlices(A, L, R);
}