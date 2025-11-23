function maxAlloys(A, B, C, D) {
    let low = 0, high = Math.min(A / 3, B / 2, C / 2, D / 1);

    while (low < high) {
        let mid = Math.floor((low + high + 1) / 2);
        if (A >= mid * 3 && B >= mid * 2 && C >= mid * 2 && D >= mid) {
            low = mid;
        } else {
            high = mid - 1;
        }
    }

    return low;
}