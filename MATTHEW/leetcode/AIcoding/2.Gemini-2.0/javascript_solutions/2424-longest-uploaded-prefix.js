var longestUploadedPrefix = function(uploaded, n) {
    let uploadedSet = new Set();
    let prefix = 0;
    for (let i = 0; i < uploaded.length; i++) {
        uploadedSet.add(uploaded[i]);
        if (uploadedSet.has(prefix + 1)) {
            let current = prefix + 1;
            while (uploadedSet.has(current)) {
                current++;
            }
            prefix = current - 1;
        }
    }
    return prefix;
};