var countAndSay = function(n) {
    if (n === 1) {
        return "1";
    }

    let currentString = "1";

    for (let i = 2; i <= n; i++) {
        let nextString = "";
        let count = 1;
        let char = currentString[0];

        for (let j = 1; j < currentString.length; j++) {
            if (currentString[j] === char) {
                count++;
            } else {
                nextString += count + char;
                char = currentString[j];
                count = 1;
            }
        }
        nextString += count + char;
        currentString = nextString;
    }

    return currentString;
};