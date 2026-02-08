var capitalizeTitle = function(s) {
    s = s.toLowerCase();
    let words = s.split(" ");
    let result = "";

    for (let i = 0; i < words.length; i++) {
        let word = words[i];
        if (word.length <= 2) {
            result += word;
        } else {
            result += word.charAt(0).toUpperCase() + word.slice(1);
        }
        if (i < words.length - 1) {
            result += " ";
        }
    }

    return result;
};