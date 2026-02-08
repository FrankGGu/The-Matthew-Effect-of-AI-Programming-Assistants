class ZeroEvenOdd {
  constructor(n) {
    this.n = n;
    this.zeroTurn = 0;
    this.evenTurn = 0;
    this.oddTurn = 0;
  }

  zero(printNumber) {
    for (let i = 1; i <= this.n; i++) {
      while (this.zeroTurn !== i) {
        Atomics.wait(this, 0, i);
      }
      printNumber(0);
      if (i % 2 === 0) {
        this.evenTurn = i / 2;
        Atomics.notify(this, 0, 1);
      } else {
        this.oddTurn = Math.floor(i / 2) + 1;
        Atomics.notify(this, 0, 1);
      }
      this.zeroTurn++;
    }
  }

  even(printNumber) {
    for (let i = 1; i <= this.n / 2; i++) {
      while (this.evenTurn !== i) {
        Atomics.wait(this, 0, i + this.n);
      }
      printNumber(2 * i);
      Atomics.notify(this, 0, 1);
    }
  }

  odd(printNumber) {
    for (let i = 1; i <= Math.floor(this.n / 2) + (this.n % 2); i++) {
      while (this.oddTurn !== i) {
        Atomics.wait(this, 0, i + this.n * 2);
      }
      printNumber(2 * i - 1);
      Atomics.notify(this, 0, 1);
    }
  }
}