-module(sol).
-export([judge/1]).

judge(Dynasty) when Dynasty == "夏" -> "夏";
judge(Dynasty) when Dynasty == "商" -> "商";
judge(Dynasty) when Dynasty == "周" -> "周";
judge(Dynasty) when Dynasty == "秦" -> "秦";
judge(Dynasty) when Dynasty == "汉" -> "汉";
judge(Dynasty) when Dynasty == "三国" -> "三国";
judge(Dynasty) when Dynasty == "晋" -> "晋";
judge(Dynasty) when Dynasty == "南北朝" -> "南北朝";
judge(Dynasty) when Dynasty == "隋" -> "隋";
judge(Dynasty) when Dynasty == "唐" -> "唐";
judge(Dynasty) when Dynasty == "宋" -> "宋";
judge(Dynasty) when Dynasty == "元" -> "元";
judge(Dynasty) when Dynasty == "明" -> "明";
judge(Dynasty) when Dynasty == "清" -> "清";
judge(_) -> "未知".