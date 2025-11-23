class DataStream {
    constructor(value, k) {
        this.value = value;
        this.k = k;
        this.count = 0;
    }

    consec(num) {
        if (num === this.value) {
            this.count++;
        } else {
            this.count = 0;
        }

        return this.count >= this.k;
    }
}