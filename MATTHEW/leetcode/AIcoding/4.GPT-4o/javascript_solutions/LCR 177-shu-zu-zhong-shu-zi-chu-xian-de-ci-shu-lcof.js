function colorMatch(colors) {
    const count = {};
    for (const color of colors) {
        count[color] = (count[color] || 0) + 1;
    }

    let pairs = 0;
    for (const key in count) {
        pairs += Math.floor(count[key] / 2);
    }

    return pairs;
}