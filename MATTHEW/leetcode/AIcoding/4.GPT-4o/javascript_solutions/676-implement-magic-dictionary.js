class MagicDictionary {
    constructor() {
        this.words = new Set();
        this.modifiedWords = new Set();
    }

    buildDict(dictionary) {
        for (const word of dictionary) {
            this.words.add(word);
            for (let i = 0; i < word.length; i++) {
                const modifiedWord = word.slice(0, i) + '*' + word.slice(i + 1);
                this.modifiedWords.add(modifiedWord);
            }
        }
    }

    search(searchWord) {
        for (let i = 0; i < searchWord.length; i++) {
            const modifiedWord = searchWord.slice(0, i) + '*' + searchWord.slice(i + 1);
            if (this.modifiedWords.has(modifiedWord)) {
                for (const word of this.words) {
                    if (word.length === searchWord.length && word !== searchWord) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}