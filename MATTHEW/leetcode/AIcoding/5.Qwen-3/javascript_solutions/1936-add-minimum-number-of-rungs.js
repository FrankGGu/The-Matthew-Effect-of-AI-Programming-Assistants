function addMinimum(rungs) {
    let required = 0;
    let prev = 0;
    for (const height of rungs) {
        const diff = height - prev;
        if (diff > 3) {
            required += Math.floor((diff - 1) / 3);
        }
        prev = height;
    }
    return required;
}