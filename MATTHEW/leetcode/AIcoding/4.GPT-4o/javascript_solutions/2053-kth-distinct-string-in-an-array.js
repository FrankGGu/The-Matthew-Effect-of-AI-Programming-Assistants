function kthDistinct(arr, k) {
    const count = {};
    for (const str of arr) {
        count[str] = (count[str] || 0) + 1;
    }
    let distinctCount = 0;
    for (const str of arr) {
        if (count[str] === 1) {
            distinctCount++;
            if (distinctCount === k) {
                return str;
            }
        }
    }
    return "";
}