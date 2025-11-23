var arrangeWords = function(text) {
    let words = text.toLowerCase().split(' ').sort((a, b) => a.length - b.length);
    return words.join(' ').charAt(0).toUpperCase() + words.join(' ').slice(1);
};