function largestTimeFromDigits(A) {
    let maxTime = -1;
    for (let i = 0; i < 4; i++) {
        for (let j = 0; j < 4; j++) {
            if (i === j) continue;
            for (let k = 0; k < 4; k++) {
                if (k === i || k === j) continue;
                let l = 6 - i - j - k;
                let hour = A[i] * 10 + A[j];
                let minute = A[k] * 10 + A[l];
                if (hour < 24 && minute < 60) {
                    maxTime = Math.max(maxTime, hour * 60 + minute);
                }
            }
        }
    }
    if (maxTime === -1) return "";
    let hours = Math.floor(maxTime / 60);
    let minutes = maxTime % 60;
    return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}`;
}