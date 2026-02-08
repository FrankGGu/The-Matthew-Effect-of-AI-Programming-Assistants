var largestTimeFromDigits = function(A) {
    let maxTime = -1;

    const permute = (arr, start) => {
        if (start === arr.length - 1) {
            const hour = arr[0] * 10 + arr[1];
            const minute = arr[2] * 10 + arr[3];
            if (hour < 24 && minute < 60) {
                const time = hour * 60 + minute;
                if (time > maxTime) {
                    maxTime = time;
                }
            }
            return;
        }

        for (let i = start; i < arr.length; i++) {
            [arr[start], arr[i]] = [arr[i], arr[start]];
            permute(arr, start + 1);
            [arr[start], arr[i]] = [arr[i], arr[start]];
        }
    };

    permute(A, 0);

    if (maxTime === -1) {
        return "";
    } else {
        const hour = Math.floor(maxTime / 60);
        const minute = maxTime % 60;
        return `${hour.toString().padStart(2, '0')}:${minute.toString().padStart(2, '0')}`;
    }
};