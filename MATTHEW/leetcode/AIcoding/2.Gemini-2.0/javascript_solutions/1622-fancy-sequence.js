var Fancy = function() {
    this.seq = [];
    this.addA = [0];
    this.mulM = [1];
    this.MOD = 1000000007;
};

Fancy.prototype.append = function(val) {
    this.seq.push(val);
    this.addA.push(this.addA[this.addA.length - 1]);
    this.mulM.push(this.mulM[this.mulM.length - 1]);
};

Fancy.prototype.addAll = function(inc) {
    this.addA[this.addA.length - 1] = (this.addA[this.addA.length - 1] + inc) % this.MOD;
};

Fancy.prototype.multAll = function(m) {
    this.addA[this.addA.length - 1] = (this.addA[this.addA.length - 1] * m) % this.MOD;
    this.mulM[this.mulM.length - 1] = (this.mulM[this.mulM.length - 1] * m) % this.MOD;
};

Fancy.prototype.getIndex = function(idx) {
    if (idx >= this.seq.length) return -1;

    let m = this.mulM[this.mulM.length - 1];
    let a = this.addA[this.addA.length - 1];
    let m_i = this.mulM[idx];
    let a_i = this.addA[idx];

    let inv_m_i = this.power(m_i, this.MOD - 2);

    let res = (this.seq[idx] * ((m * inv_m_i) % this.MOD) % this.MOD + (a - (a_i * ((m * inv_m_i) % this.MOD)) % this.MOD + this.MOD) % this.MOD) % this.MOD;

    return res;
};

Fancy.prototype.power = function(x, y) {
    let res = 1;
    x = x % this.MOD;

    while (y > 0) {
        if (y % 2 == 1)
            res = (res * x) % this.MOD;

        y = Math.floor(y / 2);
        x = (x * x) % this.MOD;
    }
    return res;
};