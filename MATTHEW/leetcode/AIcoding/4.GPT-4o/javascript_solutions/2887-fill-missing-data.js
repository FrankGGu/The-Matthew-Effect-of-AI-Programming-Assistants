function fillMissingData(data) {
    for (let i = 0; i < data.length; i++) {
        if (data[i] === null) {
            let left = i - 1;
            let right = i + 1;
            while (left >= 0 && data[left] === null) left--;
            while (right < data.length && data[right] === null) right++;
            const leftValue = left >= 0 ? data[left] : 0;
            const rightValue = right < data.length ? data[right] : 0;
            const steps = right - left - 1;
            const diff = rightValue - leftValue;
            for (let j = 1; j <= steps; j++) {
                data[left + j + 1] = leftValue + Math.floor((diff / (steps + 1)) * j);
            }
        }
    }
    return data;
}