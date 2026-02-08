var smallestString = function(s, operations) {
    for (let op of operations) {
        let [type, index] = op;
        if (type === 1) {
            s = s.slice(0, index) + String.fromCharCode(s.charCodeAt(index) + 1) + s.slice(index + 1);
        } else {
            s = s.slice(0, index) + String.fromCharCode(s.charCodeAt(index) - 1) + s.slice(index + 1);
        }
    }
    return s;
};