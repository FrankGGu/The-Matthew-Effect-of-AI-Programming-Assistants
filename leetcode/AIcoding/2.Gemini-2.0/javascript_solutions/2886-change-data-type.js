var changeDataType = function(data, type) {
    if (type === "Integer") {
        return parseInt(data);
    } else if (type === "String") {
        return String(data);
    } else if (type === "Boolean") {
        if (data === "true") {
            return true;
        } else if (data === "false") {
            return false;
        } else if (data === 0) {
            return false;
        } else {
            return true;
        }
    }
};