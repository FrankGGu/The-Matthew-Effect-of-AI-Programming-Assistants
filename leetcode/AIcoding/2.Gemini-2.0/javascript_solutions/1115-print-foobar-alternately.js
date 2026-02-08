class FooBar {
    constructor(n) {
        this.n = n;
        this.fooTurn = true;
    }

    foo(print) {
        for (let i = 0; i < this.n; i++) {
            while (!this.fooTurn) {
                Atomics.wait(new Int32Array(this), 0, 0);
            }
            print();
            this.fooTurn = false;
            Atomics.notify(new Int32Array(this), 0);
        }
    }

    bar(print) {
        for (let i = 0; i < this.n; i++) {
            while (this.fooTurn) {
                Atomics.wait(new Int32Array(this), 0, 0);
            }
            print();
            this.fooTurn = true;
            Atomics.notify(new Int32Array(this), 0);
        }
    }
}