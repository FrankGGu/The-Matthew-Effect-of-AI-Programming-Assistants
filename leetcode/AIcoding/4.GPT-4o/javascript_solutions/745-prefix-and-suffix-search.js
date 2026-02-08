class WordFilter {
    constructor(words) {
        this.map = new Map();
        for (let i = 0; i < words.length; i++) {
            const word = words[i];
            const len = word.length;
            for (let j = 0; j <= len; j++) {
                this.map.set(word.substring(0, j), i);
            }
        }
    }

    f(prefix, suffix) {
        const candidates = [];
        for (let j = suffix.length; j >= 0; j--) {
            const key = suffix.substring(j);
            if (this.map.has(key)) {
                candidates.push(this.map.get(key));
            }
        }
        let maxIndex = -1;
        for (const index of candidates) {
            const word = this.words[index];
            if (word.startsWith(prefix)) {
                maxIndex = Math.max(maxIndex, index);
            }
        }
        return maxIndex;
    }
}