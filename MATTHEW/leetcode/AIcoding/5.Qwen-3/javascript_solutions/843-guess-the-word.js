var findSecretWord = function(wordlist, master) {
    var n = 0;
    while (n < 10) {
        var count = {};
        var candidate = wordlist[Math.floor(Math.random() * wordlist.length)];
        for (var i = 0; i < wordlist.length; i++) {
            var match = 0;
            for (var j = 0; j < 6; j++) {
                if (candidate[j] === wordlist[i][j]) match++;
            }
            if (match === 0) continue;
            count[match] = count[match] ? count[match] + 1 : 1;
        }
        var guess = wordlist[0];
        var max = 0;
        for (var i = 0; i < wordlist.length; i++) {
            var current = 0;
            for (var j = 0; j < 6; j++) {
                if (guess[j] === wordlist[i][j]) current++;
            }
            if (current > max) {
                max = current;
                guess = wordlist[i];
            }
        }
        var res = master.guess(guess);
        if (res === 6) break;
        var newWordlist = [];
        for (var i = 0; i < wordlist.length; i++) {
            var match = 0;
            for (var j = 0; j < 6; j++) {
                if (guess[j] === wordlist[i][j]) match++;
            }
            if (match === res) newWordlist.push(wordlist[i]);
        }
        wordlist = newWordlist;
        n++;
    }
};