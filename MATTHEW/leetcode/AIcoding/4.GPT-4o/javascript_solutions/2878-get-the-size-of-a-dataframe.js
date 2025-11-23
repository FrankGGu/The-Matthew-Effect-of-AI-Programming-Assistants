class DataFrame {
    constructor(data) {
        this.data = data;
    }

    getSize() {
        return [this.data.length, this.data[0] ? this.data[0].length : 0];
    }
}