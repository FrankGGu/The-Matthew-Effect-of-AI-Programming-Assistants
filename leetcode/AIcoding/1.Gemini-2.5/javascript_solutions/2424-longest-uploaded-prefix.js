class LUPrefix {
    constructor(n) {
        this.uploaded = new Array(n + 1).fill(false);
        this.longestPrefix = 0;
        this.n = n;
    }

    upload(video) {
        this.uploaded[video] = true;
        while (this.longestPrefix + 1 <= this.n && this.uploaded[this.longestPrefix + 1]) {
            this.longestPrefix++;
        }
    }

    longest() {
        return this.longestPrefix;
    }
}