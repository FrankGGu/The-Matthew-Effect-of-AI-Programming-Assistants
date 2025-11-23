class DataStream {
    constructor(value, k) {
        this.value = value;
        this.k = k;
        this.count = 0;
    }

    consec(num) {
        if (num === this.value) {
            this.count++;
            return this.count >= this.k;
        } else {
            this.count = 1;
            this.value = num;
            return false;
        }
    }
}