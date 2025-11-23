var truncateSentence = function(s, k) {
    const words = s.split(' ');
    const truncated = words.slice(0, k);
    return truncated.join(' ');
};