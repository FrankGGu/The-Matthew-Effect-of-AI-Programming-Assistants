class Foo {
    constructor() {
        this.p1 = null;
        this.p2 = null;
    }

    async first(printFirst) {
        await printFirst();
        this.p1 = true;
    }

    async second(printSecond) {
        while (!this.p1) {
            await new Promise(resolve => setTimeout(resolve, 0));
        }
        await printSecond();
        this.p2 = true;
    }

    async third(printThird) {
        while (!this.p2) {
            await new Promise(resolve => setTimeout(resolve, 0));
        }
        await printThird();
    }
}