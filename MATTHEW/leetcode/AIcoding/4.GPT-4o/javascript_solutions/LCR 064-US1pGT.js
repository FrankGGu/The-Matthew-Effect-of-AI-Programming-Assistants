class MagicDictionary {
    constructor() {
        this.map = new Map();
    }

    buildDict(dictionary) {
        for (const word of dictionary) {
            const len = word.length;
            if (!this.map.has(len)) {
                this.map.set(len, []);
            }
            this.map.get(len).push(word);
        }
    }

    search(searchWord) {
        const len = searchWord.length;
        if (!this.map.has(len)) return false;

        for (const word of this.map.get(len)) {
            let diffCount = 0;
            for (let i = 0; i < len; i++) {
                if (word[i] !== searchWord[i]) {
                    diffCount++;
                }
                if (diffCount > 1) break;
            }
            if (diffCount === 1) return true;
        }
        return false;
    }
}