function minPerimeter(n) {
    let minPerimeter = Infinity;
    for (let length = 1; length * length <= n; length++) {
        let width = Math.ceil(n / length);
        let perimeter = 2 * (length + width);
        minPerimeter = Math.min(minPerimeter, perimeter);
    }
    return minPerimeter;
}