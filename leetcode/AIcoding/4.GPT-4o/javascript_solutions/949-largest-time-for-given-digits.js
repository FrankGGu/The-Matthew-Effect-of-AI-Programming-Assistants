var largestTimeFromDigits = function(A) {
    let maxTime = "";

    const permute = (arr, l, r) => {
        if (l === r) {
            const time = `${arr[0]}${arr[1]}:${arr[2]}${arr[3]}`;
            if (isValidTime(time) && time > maxTime) {
                maxTime = time;
            }
        } else {
            for (let i = l; i <= r; i++) {
                [arr[l], arr[i]] = [arr[i], arr[l]];
                permute(arr, l + 1, r);
                [arr[l], arr[i]] = [arr[i], arr[l]];
            }
        }
    };

    const isValidTime = (time) => {
        const [hh, mm] = time.split(":").map(Number);
        return hh < 24 && mm < 60;
    };

    permute(A, 0, A.length - 1);
    return maxTime ? maxTime : "";
};