var placeWordInCrossword = function(board, word) {
    const m = board.length;
    const n = board[0].length;
    const wordLen = word.length;

    function check(slotStr, targetWord) {
        if (slotStr.length !== targetWord.length) {
            return false;
        }

        let canPlaceForward = true;
        let canPlaceBackward = true;

        for (let i = 0; i < wordLen; i++) {
            if (slotStr[i] !== ' ' && slotStr[i] !== targetWord[i]) {
                canPlaceForward = false;
            }
            if (slotStr[i] !== ' ' && slotStr[i] !== targetWord[wordLen - 1 - i]) {
                canPlaceBackward = false;
            }
            if (!canPlaceForward && !canPlaceBackward) {
                return false;
            }
        }
        return canPlaceForward || canPlaceBackward;
    }

    for (let r = 0; r < m; r++) {
        const rowStr = board[r].join('');
        const slots = rowStr.split('#');
        for (const slot of slots) {
            if (check(slot, word)) {
                return true;
            }
        }
    }

    for (let c = 0; c < n; c++) {
        let colArr = [];
        for (let r = 0; r < m; r++) {
            colArr.push(board[r][c]);
        }
        const colStr = colArr.join('');
        const slots = colStr.split('#');
        for (const slot of slots) {
            if (check(slot, word)) {
                return true;
            }
        }
    }

    return false;
};