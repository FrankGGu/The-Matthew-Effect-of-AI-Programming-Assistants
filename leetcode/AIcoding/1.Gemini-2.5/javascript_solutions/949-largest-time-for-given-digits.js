var largestTimeFromDigits = function(arr) {
    let maxTime = "";

    for (let i = 0; i < 4; i++) {
        for (let j = 0; j < 4; j++) {
            if (j === i) continue;
            for (let k = 0; k < 4; k++) {
                if (k === i || k === j) continue;
                for (let l = 0; l < 4; l++) {
                    if (l === i || l === j || l === k) continue;

                    const h1 = arr[i];
                    const h2 = arr[j];
                    const m1 = arr[k];
                    const m2 = arr[l];

                    const hours = h1 * 10 + h2;
                    const minutes = m1 * 10 + m2;

                    if (hours < 24 && minutes < 60) {
                        const currentTime = String(hours).padStart(2, '0') + ":" + String(minutes).padStart(2, '0');
                        if (currentTime > maxTime) {
                            maxTime = currentTime;
                        }
                    }
                }
            }
        }
    }

    return maxTime;
};