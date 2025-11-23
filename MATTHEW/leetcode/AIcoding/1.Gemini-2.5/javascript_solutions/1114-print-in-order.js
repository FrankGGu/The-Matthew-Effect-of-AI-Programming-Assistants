class Foo {
    constructor() {
        this.firstPromise = new Promise(resolve => {
            this.resolveFirst = resolve;
        });
        this.secondPromise = new Promise(resolve => {
            this.resolveSecond = resolve;
        });
    }

    async first(printFirst) {
        printFirst();
        this.resolveFirst();
    }

    async second(printSecond) {
        await this.firstPromise;
        printSecond();
        this.resolveSecond();
    }

    async third(printThird) {
        await this.secondPromise;
        printThird();
    }
}