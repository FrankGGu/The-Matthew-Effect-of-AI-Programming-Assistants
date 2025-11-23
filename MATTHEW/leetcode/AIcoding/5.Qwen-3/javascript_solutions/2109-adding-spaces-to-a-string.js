function addingSpaces(s, spaces) {
    const result = [];
    let prev = 0;
    for (const space of spaces) {
        result.push(s.slice(prev, space));
        result.push(' ');
        prev = space;
    }
    result.push(s.slice(prev));
    return result.join('');
}