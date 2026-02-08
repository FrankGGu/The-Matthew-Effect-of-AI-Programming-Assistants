function prevPermSort(A) {
    let n = A.length;
    for (let i = n - 2; i >= 0; i--) {
        if (A[i] > A[i + 1]) {
            let j = n - 1;
            while (A[j] >= A[i]) j--;
            [A[i], A[j]] = [A[j], A[i]];
            return A;
        }
    }
    return A;
}