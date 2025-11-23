class SuffixArray {
    constructor(strings) {
        this.strings = strings;
        this.suffixes = [];
        this.buildSuffixArray();
    }

    buildSuffixArray() {
        for (let index = 0; index < this.strings.length; index++) {
            const str = this.strings[index];
            for (let i = 0; i < str.length; i++) {
                this.suffixes.push({ suffix: str.slice(i), index });
            }
        }
        this.suffixes.sort((a, b) => a.suffix.localeCompare(b.suffix));
    }

    longestCommonSuffix() {
        let maxSuffix = '';
        for (let i = 1; i < this.suffixes.length; i++) {
            const commonSuffix = this.getCommonSuffix(this.suffixes[i - 1].suffix, this.suffixes[i].suffix);
            if (commonSuffix.length > maxSuffix.length) {
                maxSuffix = commonSuffix;
            }
        }
        return maxSuffix;
    }

    getCommonSuffix(s1, s2) {
        let i = 1;
        while (s1[s1.length - i] === s2[s2.length - i] && i <= s1.length && i <= s2.length) {
            i++;
        }
        return s1.slice(s1.length - (i - 1));
    }
}

var longestCommonSuffix = function (strings) {
    const suffixArray = new SuffixArray(strings);
    return suffixArray.longestCommonSuffix();
};