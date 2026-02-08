var WordFilter = function(words) {
    this.map = new Map();

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        const n = word.length;

        for (let pLen = 1; pLen <= n; pLen++) {
            const prefix = word.substring(0, pLen);

            for (let sLen = 1; sLen <= n; sLen++) {
                const suffix = word.substring(n - sLen);
                const key = prefix + "#" + suffix;
                this.map.set(key, i);
            }
        }
    }
};

WordFilter.prototype.f = function(prefix, suffix) {
    const key = prefix + "#" + suffix;
    const result = this.map.get(key);
    return result !== undefined ? result : -1;
};