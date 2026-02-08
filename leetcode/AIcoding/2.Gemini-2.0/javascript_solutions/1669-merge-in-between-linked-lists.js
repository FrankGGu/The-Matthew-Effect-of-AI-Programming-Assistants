var mergeInBetween = function(list1, a, b, list2) {
    let head = list1;
    let prev = null;
    let curr = list1;
    let i = 0;

    while(curr){
        if(i === a){
            prev = curr;
        }
        if(i === b + 1){
            break;
        }
        curr = curr.next;
        i++;
    }

    let list2Tail = list2;
    while(list2Tail.next){
        list2Tail = list2Tail.next;
    }

    prev.next = list2;
    list2Tail.next = curr;

    return head;
};