var MKAverage = function(m, k) {
    this.m = m;
    this.k = k;
    this.stream = [];
};

MKAverage.prototype.addElement = function(num) {
    this.stream.push(num);
};

MKAverage.prototype.calculateMKAverage = function() {
    if (this.stream.length < this.m) {
        return -1;
    }

    if (this.stream.length === this.m) {
        const sorted = [...this.stream].sort((a, b) => a - b);
        let sum = 0;
        for (let i = this.k; i < this.m - this.k; i++) {
            sum += sorted[i];
        }
        return Math.floor(sum / (this.m - 2 * this.k));
    }

    const lastM = this.stream.slice(this.stream.length - this.m);
    const sorted = [...lastM].sort((a, b) => a - b);
    let sum = 0;
    for (let i = this.k; i < this.m - this.k; i++) {
        sum += sorted[i];
    }
    return Math.floor(sum / (this.m - 2 * this.k));
};