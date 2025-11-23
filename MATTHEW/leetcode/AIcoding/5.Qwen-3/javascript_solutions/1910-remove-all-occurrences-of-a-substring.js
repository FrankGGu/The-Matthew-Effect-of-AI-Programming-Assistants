function removeOccurrences(s, part) {
    let index;
    while ((index = s.indexOf(part)) !== -1) {
        s = s.substring(0, index) + s.substring(index + part.length);
    }
    return s;
}