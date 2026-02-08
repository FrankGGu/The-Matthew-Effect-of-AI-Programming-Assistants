var minAddToMakeValid = function(s) {
    let openNeeded = 0;
    let closeNeeded = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            openNeeded++;
        } else { // s[i] === ')'
            if (openNeeded > 0) {
                openNeeded--;
            } else {
                closeNeeded++;
            }
        }
    }

    return openNeeded + closeNeeded;
};