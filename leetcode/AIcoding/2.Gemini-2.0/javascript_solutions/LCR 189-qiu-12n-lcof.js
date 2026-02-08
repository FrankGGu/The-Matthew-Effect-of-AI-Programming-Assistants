class Accumulator {
  constructor() {
    this.value = 0;
  }

  accumulate(amount) {
    this.value += amount;
  }

  getValue() {
    return this.value;
  }
}