var minimumPushes = function(word) {
    const freqMap = new Map();
    for (const char of word) {
        freqMap.set(char, (freqMap.get(char) || 0) + 1);
    }

    const frequencies = Array.from(freqMap.values());
    frequencies.sort((a, b) => b - a);

    const buttonLoads = new Array(9).fill(0);
    let totalPushes = 0;

    for (let i = 0; i < frequencies.length; i++) {
        const currentFreq = frequencies[i];

        let minLoad = Infinity;
        let minLoadButtonIndex = -1;

        for (let j = 0; j < buttonLoads.length; j++) {
            if (buttonLoads[j] < minLoad) {
                minLoad = buttonLoads[j];
                minLoadButtonIndex = j;
            }
        }

        const pushesPerChar = minLoad + 1;
        totalPushes += currentFreq * pushesPerChar;

        buttonLoads[minLoadButtonIndex]++;
    }

    return totalPushes;
};