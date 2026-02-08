var longestBeautifulSubstring = function(word) {
    let vowels = "aeiou";
    let maxLen = 0;
    let i = 0;

    while (i < word.length) {
        let j = i;
        let vowelIndex = 0;

        while (j < word.length && word[j] === vowels[vowelIndex]) {
            j++;
        }

        if (j > i && vowelIndex === 0) {
            let currentLen = 1;
            let k = i + 1;
            vowelIndex = 0;

            while (k < word.length) {
                if (word[k] >= vowels[vowelIndex] && word[k] <= vowels[4]) {
                    if(word[k] === vowels[vowelIndex]){
                        currentLen++;
                        k++;
                    } else {
                        vowelIndex++;
                        if(word[k] === vowels[vowelIndex]){
                            currentLen++;
                            k++;
                        } else {
                            break;
                        }
                    }
                } else {
                    break;
                }
            }

            if(vowelIndex === 4){
                maxLen = Math.max(maxLen, currentLen);
            }
        }

        let nextIndex = i + 1;
        while(nextIndex < word.length && word[nextIndex] <= word[i]){
            nextIndex++;
        }
        if(nextIndex === i + 1){
            i++;
        }else{
            i = nextIndex;
        }
    }

    return maxLen;
};