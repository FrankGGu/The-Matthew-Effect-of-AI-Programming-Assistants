var lengthOfLastWord = function(s) {
    s = s.trim();
    let lastIndex = s.lastIndexOf(' ');
    if (lastIndex === -1) {
        return s.length;
    }
    return s.length - lastIndex - 1;
};