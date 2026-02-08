function transformedStringLength(s, transformations) {
    let length = s.length;
    for (let t of transformations) {
        length += t.length - 1;
    }
    return length;
}