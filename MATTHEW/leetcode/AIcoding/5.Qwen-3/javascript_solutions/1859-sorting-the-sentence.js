function sortSentence(s) {
    return s.split(' ').sort((a, b) => a[a.length - 1] - b[b.length - 1]).map(word => word.slice(0, -1)).join(' ');
}