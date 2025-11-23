var sortVowels = function(s) {
    const vowels = "aeiouAEIOU";
    let vowelList = [];
    for (let i = 0; i < s.length; i++) {
        if (vowels.includes(s[i])) {
            vowelList.push(s[i]);
        }
    }
    vowelList.sort();
    let result = "";
    let vowelIndex = 0;
    for (let i = 0; i < s.length; i++) {
        if (vowels.includes(s[i])) {
            result += vowelList[vowelIndex];
            vowelIndex++;
        } else {
            result += s[i];
        }
    }
    return result;
};