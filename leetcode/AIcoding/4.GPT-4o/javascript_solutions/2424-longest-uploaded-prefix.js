class LUPrefix {
    constructor(n) {
        this.videos = new Array(n + 1).fill(false);
        this.uploaded = 0;
    }

    upload(video) {
        this.videos[video] = true;
        while (this.uploaded + 1 < this.videos.length && this.videos[this.uploaded + 1]) {
            this.uploaded++;
        }
    }

    longest() {
        return this.uploaded;
    }
}