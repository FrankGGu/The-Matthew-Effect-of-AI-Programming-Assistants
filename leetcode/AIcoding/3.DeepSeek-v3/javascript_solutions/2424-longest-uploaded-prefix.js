class LUPrefix {
    constructor(n) {
        this.uploaded = new Set();
        this.prefix = 0;
    }

    upload(video) {
        this.uploaded.add(video);
        while (this.uploaded.has(this.prefix + 1)) {
            this.prefix++;
        }
    }

    longest() {
        return this.prefix;
    }
}