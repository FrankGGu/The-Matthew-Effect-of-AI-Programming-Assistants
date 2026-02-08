class WordFilter {
    constructor(words) {
        this.map = new Map();
        for (let i = 0; i < words.length; i++) {
            const word = words[i];
            for (let j = 0; j <= word.length; j++) {
                for (let k = 0; k <= word.length; k++) {
                    const prefix = word.substring(0, j);
                    const suffix = word.substring(word.length - k);
                    this.map.set(prefix + "#" + suffix, i);
                }
            }
        }
    }

    f(prefix, suffix) {
        const key = prefix + "#" + suffix;
        return this.map.has(key) ? this.map.get(key) : -1;
    }
}