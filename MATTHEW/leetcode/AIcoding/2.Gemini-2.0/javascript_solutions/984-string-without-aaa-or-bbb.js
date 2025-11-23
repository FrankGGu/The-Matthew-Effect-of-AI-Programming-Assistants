var strWithout3a3b = function(a, b) {
    let result = "";
    while (a > 0 || b > 0) {
        if (a > b) {
            if (a >= 2 && (result.length < 2 || result.slice(-2) !== "aa")) {
                result += "aa";
                a -= 2;
            } else {
                result += "a";
                a -= 1;
            }
            if (b > 0) {
                result += "b";
                b -= 1;
            }
        } else if (b > a) {
            if (b >= 2 && (result.length < 2 || result.slice(-2) !== "bb")) {
                result += "bb";
                b -= 2;
            } else {
                result += "b";
                b -= 1;
            }
            if (a > 0) {
                result += "a";
                a -= 1;
            }
        } else {
            if (a > 0) {
                result += "a";
                a -= 1;
            }
            if (b > 0) {
                result += "b";
                b -= 1;
            }
        }
    }
    return result;
};